module.exports = (sequelize)->
    Names = sequelize.Names
    Attend = sequelize.Attend
    Sequelize = sequelize.Sequelize
    return {
        index: (req, res)->
            # showing the list
            sequelize.sequelize.query("SELECT MAX(Names.id) id, Names.number, Names.name, MIN(Attends.leftFlag) leftFlag, MAX(Attends.leftAt) leftAt FROM Names LEFT JOIN Attends ON Names.id = Attends.userId GROUP BY Names.id;",
                type: Sequelize.QueryTypes.SELECT
            )
            .then (result)->
                res.send result.map (res)->
                    if res.leftFlag isnt 1
                        res.leftFlag = 0
                    res.leftFlag = res.leftFlag is 1
                    unless res.leftFlag
                        res.leftAt = null
                    res
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
                Attend.create
                    userId: result.id
                    leftFlag: 0
                .then (res)->
                    console.log "checkin"
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
        }
