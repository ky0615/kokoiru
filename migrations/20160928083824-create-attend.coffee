module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'Attends',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      userId:
        type: Sequelize.INTEGER,
        references:
          model: 'names'
          key: 'id'
        allowNull: false
        onUpdate: 'cascade'
        onDelete: 'cascade'
      leftFlag:
        type: Sequelize.BOOLEAN
        allowNull: false
        defaultValue: false
      leftAt:
        type: Sequelize.DATE
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Attends'
