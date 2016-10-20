module.exports = (sequelize, DataTypes) ->
  Chat = sequelize.define('Chat', {
    text: DataTypes.STRING
  },
    classMethods: associate: (models) ->
      # associations can be defined here
      return
    tableName: "Chat"
  )
  Chat
