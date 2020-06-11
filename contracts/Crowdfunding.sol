pragma solidity >=0.5.0 <0.7.0;

import "@aragon/os/contracts/apps/AragonApp.sol";

/**
 * @title Crowdfuding
 * @author Mauricio Coronel
 * @notice Contrato encargado de las principales operaciones de manejo de entidades y fondos.
 * @dev
 */
contract Crowdfunding is AragonApp {
    enum EntityType {Dac, Campaign, Milestone}

    /// @dev Estructura que define la base de una entidad.
    struct Entity {
        uint32 id; // Identificación de la entidad
        EntityType entityType;
    }

    /// @dev Desde esta variable son generados todos los identificadores de entidades.
    uint32 entityIds;

    mapping(uint32 => Entity) public entities;

    /**
     * @notice Crea una entidad base del tipo `entityType`.
     * @param entityType tipo de la entidad a crear.
     * @return entityId identificador de la entidad creada.
     */
    function createEntity(EntityType entityType)
        external
        returns (uint32 entityId)
    {
        entityId = entityIds++; // Generación del Id único por entidad.
        entities[entityId] = Entity(entityId, entityType);
    }

    function getEntities() public view returns (mapping(uint32 => Entity)) {
        return entities;
    }
}
