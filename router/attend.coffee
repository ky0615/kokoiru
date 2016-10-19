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
        create: (req, res)->
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