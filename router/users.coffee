sequelize = require "../models"
Names = sequelize.Names

module.exports =
    index: (req, res)->
        # showing the list
        Names.findAll()
        .then (result)->
            res.send result
    show: (req, res)->
        # showing the users
        unless req?.params?.id
            res.status 500
            .send [
                message: "Argument must be number"
            ]
            return
        Names.find
            where:
                $or:[
                    number: req.params.id
                ,
                    id: req.params.id
                ]
        .then (result)->
            unless result
                res.status 404
                .send errors: [
                    message: "#{req.params.id} is not found"
                ]
                return
            res.send result
        .catch (err)->
            res.status 404
            .send errors: err.errors
    create: (req, res)->
        # creating the user
        Names.create
            number: req.body.number
            name: req.body.name
        .then (result)->
            res.send result
        .catch (err)->
            res.status 500
            .send errors: err.errors
    update: (req, res)->
        # update the user
        unless req?.params?.id
            res.status 500
            .send [
                message: "Argument must be number"
            ]
            return
        Names.find
            where:
                $or:[
                    number: req.params.id
                ,
                    id: req.params.id
                ]
        .then (result)->
            unless result
                res.status 404
                .send errors: [
                    message: "#{req.params.id} is not found"
                ]
                return
            result.update req.body
        .then (result)->
            res.send result
        .catch (err)->
            res.status 500
            .send errors: err.errors
    destroy: (req, res)->
        # destroy the user
        unless req?.params?.id
            res.status 500
            .send [
                message: "Argument must be number"
            ]
            return
        Names.find
            where:
                $or:[
                    number: req.params.id
                ,
                    id: req.params.id
                ]
        .then (result)->
            unless result
                res.status 404
                .send errors: [
                    message: "#{req.params.id} is not found"
                ]
                return
            result.destroy()
        .then (result)->
            res.send result
        .catch (err)->
            res.status 500
            .send errors: err.errors
