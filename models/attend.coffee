module.exports = (sequelize, DataTypes) ->
  Attend = sequelize.define('Attend', {
    userId: DataTypes.INTEGER
    leftFlag: DataTypes.BOOLEAN
    leftAt: DataTypes.DATE
  }, classMethods: associate: (models) ->
    # associations can be defined here
    models.Attend.belongsTo models.Names, as: "user"
    return
  )
  Attend
