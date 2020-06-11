pragma solidity >=0.5.0 <0.7.0;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "./Crowdfunding.sol";

/**
 * @title Crowdfuding de DACs
 * @author Mauricio Coronel
 * @notice Contrato encargado de las operaciones sobre DACs.
 * @dev
 */
contract DacCrowdfunding is AragonApp {
    bytes32 public constant DAC_CREATE_ROLE = keccak256("DAC_CREATE_ROLE");
    bytes32 public constant CROWDFUNDING_APP_ID = keccak256("crowdfunding");
    bytes32 public constant CROWDFUNDING_APP = keccak256(
        APP_BASES_NAMESPACE,
        CROWDFUNDING_APP_ID
    );

    enum Status {Active, Cancelled}

    /**
     * @dev Estructura que define los datos de una DAC.
     */
    struct Dac {
        uint32 id; // Identificación de la entidad
        string title;
        string description;
        string url;
        string imageCid; // IPFS Content ID.
        address delegateAddress;
        Status status;
    }

    mapping(uint32 => Dac) public dacs;

    event DacCreated(uint32 id);

    Crowdfunfing private crowdfunding;

    function initialize() public onlyInit {
        crowdfunding = Crowdfunfing(kernel.getApp(CROWDFUNDING_APP));
        initialized();
    }

    function create(
        string title,
        string description,
        string url,
        string imageCid,
        address delegateAddress
    ) external auth(DAC_CREATE_ROLE) {
        entityId = crowdfunding.createEntity(Crowdfunfing.EntityType.Dac);
        dacs[entityId] = Dac(
            entityId,
            title,
            description,
            url,
            imageCid,
            delegateAddress
        );
        emit DacCreated(entityId);
    }

    function getDacs() public view returns (mapping(uint32 => Dac)) {
        return dacs;
    }
}
