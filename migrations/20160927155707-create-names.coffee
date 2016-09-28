module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Names',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      number:
        type: Sequelize.STRING
        unique: true
      name: type: Sequelize.STRING
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Names'
