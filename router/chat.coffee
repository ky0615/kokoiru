module.exports = (sequelize)->
    Chat = sequelize.Chat
    return {
        index: (req, res)->
            # showing the list
            Chat.findAll
                order: "createdAt DESC"
            .then (result)->
                res.send result
        create: (req, res)->
            unless req?.body?.text
                res.status 500
                    .send errors: [
                        message: "Text was required."
                    ]
                return
            Chat.create
                text: req.body.text
            .then (result)->
                res.send result
            .catch (err)->
                res.send err
    }
