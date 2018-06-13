package com.boot.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.boot.model.Shipwreck;
import com.boot.repository.ShipwreckRepository;

import net.minidev.json.JSONObject;

@RestController
@RequestMapping("api/v1/")
public class ShipwreckController {

    @Autowired
    private ShipwreckRepository shipwreckRepository;

    // Return all wrecks from the repository
    // link: http://localhost:8080/api/v1/shipwrecks
    @RequestMapping(value = "shipwrecks", method = RequestMethod.GET)
    public List<Shipwreck> list() {
        return shipwreckRepository.findAll();
    }

    // Create and add a new shipwreck 
    // link: http://localhost:8080/api/v1/shipwrecks
    @RequestMapping(value = "shipwrecks", method = RequestMethod.POST)
    public Shipwreck create(@RequestBody Shipwreck shipwreck) {
        return shipwreckRepository.saveAndFlush(shipwreck);
    }


    // Return shipwreck having ID
    // link: http://localhost:8080/api/v1/shipwrecks/{id}
    @RequestMapping(value = "shipwrecks/{id}", method = RequestMethod.GET)
    public Shipwreck get(@PathVariable Long id) {
        return shipwreckRepository.findOne(id);
    }

    // Replace an existing shipwreck having ID with a new one
    // link: http://localhost:8080/api/v1/shipwrecks/{id}
    @RequestMapping(value = "shipwrecks/{id}", method = RequestMethod.PUT)
    public Shipwreck update(@PathVariable Long id, @RequestBody Shipwreck shipwreck) {
        Shipwreck existingShipwreck = shipwreckRepository.findOne(id);
        BeanUtils.copyProperties(shipwreck, existingShipwreck);
        return shipwreckRepository.saveAndFlush(existingShipwreck);
    }

    // Delete an existing shipwreck having ID with a new one
    // link: http://localhost:8080/api/v1/shipwrecks/{id}
    @RequestMapping(value = "shipwrecks/{id}", method = RequestMethod.DELETE)
    public Shipwreck delete(@PathVariable Long id) {
        Shipwreck existingShipwreck = shipwreckRepository.findOne(id);
        shipwreckRepository.delete(existingShipwreck);
        return existingShipwreck;
    }
    
    // Delete all existing shipwreck
    // link: http://localhost:8080/api/v1/shipwrecks}
    @RequestMapping(value = "shipwrecks", method = RequestMethod.DELETE)
    //@ResponseStatus(value=HttpStatus.OK)
    public String delete() {
    	List<Shipwreck> shipwrecks = shipwreckRepository.findAll();
    	int nb = shipwrecks.size();
        shipwreckRepository.deleteAll();
        JSONObject json = new JSONObject();
        json.put("number", ""+nb);
        return "json";
    }

}
