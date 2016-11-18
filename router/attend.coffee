_ = require "lodash"
module.exports = (sequelize)->
    Names = sequelize.Names
    Attend = sequelize.Attend
    Sequelize = sequelize.Sequelize
    return {
        index: (req, res)->
            # showing the list
            Attend.findAll
                include:[
                    model : Names
                    as: "user"
                ]
                # group: "leftFlag"
            .then (result)->
                res.send result
        heatMap: (req, res)->
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
                Attend.findAll
                    where: userId: result.id
            .then (result)->
                val = _.map result, (val)->
                  Math.floor(new Date(val.createdAt).getTime() / 1000)
                res.send _.reduce val, (result, val)->
                    if not _.isObject result
                      re = {}
                      re[result] = 1
                      return re
                    result[val] = 1
                    result
            .catch (err)->
                res.status 404
                .send errors: err.errors
        create: (req, res)->
            console.log req.body
            unless req.body.number
              res.send
                status: "色々と足りない"
              return
            Names.find
                where:
                    number: req.body.number
            .then (user)->
                if user
                    return user
                Names.create
                    number: req.body.number
                    name: req.body.name
            .then (user)->
                Attend.find
                    where:
                        userId: user.id
                    order: "createdAt DESC"
                .then (attend)->
                    if attend is null or attend.leftFlag
                        return Attend.create
                                userId: user.id
                                leftFlag: 0
                    return attend.update
                        leftFlag: 1
                        leftAt: new Date()
            .then (result)->
                res.send result
            .catch (err)->
                res.send err
        leavingAll: (req, res)->
            Attend.update
                leftFlag: 1
                leftAt: new Date()
            ,
                where:
                    leftFlag: 0
            .then (result)->
                console.log result
                res.send
                    status: "success"

    }
