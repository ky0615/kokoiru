module.exports = (sequelize, DataTypes) ->
  Names = sequelize.define('Names', {
    number:
        type: DataTypes.STRING
        unique: true
    name: DataTypes.STRING
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  Names
