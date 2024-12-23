// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.8.0;

import "starkware/solidity/libraries/RolesLib.sol"; 
import {SphereXProtected} from "@spherex-xyz/contracts/src/SphereXProtected.sol";
 

abstract contract Roles is SphereXProtected {
    // This flag dermine if the GOVERNANCE_ADMIN role can be renounced.
    bool immutable fullyRenouncable;

    constructor(bool renounceable) {
        fullyRenouncable = renounceable;
        RolesLib.initialize();
    }

    // MODIFIERS.
    modifier onlyAppGovernor() {
        require(isAppGovernor(AccessControl._msgSender()), "ONLY_APP_GOVERNOR");
        _;
    }

    modifier onlyOperator() {
        require(isOperator(AccessControl._msgSender()), "ONLY_OPERATOR");
        _;
    }

    modifier onlySecurityAdmin() {
        require(isSecurityAdmin(AccessControl._msgSender()), "ONLY_SECURITY_ADMIN");
        _;
    }

    modifier onlySecurityAgent() {
        require(isSecurityAgent(AccessControl._msgSender()), "ONLY_SECURITY_AGENT");
        _;
    }

    modifier onlyTokenAdmin() {
        require(isTokenAdmin(AccessControl._msgSender()), "ONLY_TOKEN_ADMIN");
        _;
    }

    modifier onlyUpgradeGovernor() {
        require(isUpgradeGovernor(AccessControl._msgSender()), "ONLY_UPGRADE_GOVERNOR");
        _;
    }

    modifier notSelf(address account) {
        require(account != AccessControl._msgSender(), "CANNOT_PERFORM_ON_SELF");
        _;
    }

    // Is holding role.
    function isAppGovernor(address account) public view returns (bool) {
        return AccessControl.hasRole(APP_GOVERNOR, account);
    }

    function isAppRoleAdmin(address account) public view returns (bool) {
        return AccessControl.hasRole(APP_ROLE_ADMIN, account);
    }

    function isGovernanceAdmin(address account) public view returns (bool) {
        return AccessControl.hasRole(GOVERNANCE_ADMIN, account);
    }

    function isOperator(address account) public view returns (bool) {
        return AccessControl.hasRole(OPERATOR, account);
    }

    function isSecurityAdmin(address account) public view returns (bool) {
        return AccessControl.hasRole(SECURITY_ADMIN, account);
    }

    function isSecurityAgent(address account) public view returns (bool) {
        return AccessControl.hasRole(SECURITY_AGENT, account);
    }

    function isTokenAdmin(address account) public view returns (bool) {
        return AccessControl.hasRole(TOKEN_ADMIN, account);
    }

    function isUpgradeGovernor(address account) public view returns (bool) {
        return AccessControl.hasRole(UPGRADE_GOVERNOR, account);
    }

    // Register Role.
    function registerAppGovernor(address account) external sphereXGuardExternal(0x7b0c10d8) {
        AccessControl.grantRole(APP_GOVERNOR, account);
    }

    function registerAppRoleAdmin(address account) external sphereXGuardExternal(0x7df91a80) {
        AccessControl.grantRole(APP_ROLE_ADMIN, account);
    }

    function registerGovernanceAdmin(address account) external sphereXGuardExternal(0x868fadbf) {
        AccessControl.grantRole(GOVERNANCE_ADMIN, account);
    }

    function registerOperator(address account) external sphereXGuardExternal(0x3af3c3e6) {
        AccessControl.grantRole(OPERATOR, account);
    }

    function registerSecurityAdmin(address account) external sphereXGuardExternal(0x5207d93e) {
        AccessControl.grantRole(SECURITY_ADMIN, account);
    }

    function registerSecurityAgent(address account) external sphereXGuardExternal(0x50ab0e0d) {
        AccessControl.grantRole(SECURITY_AGENT, account);
    }

    function registerTokenAdmin(address account) external sphereXGuardExternal(0xb00257f3) {
        AccessControl.grantRole(TOKEN_ADMIN, account);
    }

    function registerUpgradeGovernor(address account) external sphereXGuardExternal(0xadd4c6ce) {
        AccessControl.grantRole(UPGRADE_GOVERNOR, account);
    }

    // Revoke Role.
    function revokeAppGovernor(address account) external sphereXGuardExternal(0x735a3c37) {
        AccessControl.revokeRole(APP_GOVERNOR, account);
    }

    function revokeAppRoleAdmin(address account) external notSelf(account) sphereXGuardExternal(0x07830d09) {
        AccessControl.revokeRole(APP_ROLE_ADMIN, account);
    }

    function revokeGovernanceAdmin(address account) external notSelf(account) sphereXGuardExternal(0x74e3bba3) {
        AccessControl.revokeRole(GOVERNANCE_ADMIN, account);
    }

    function revokeOperator(address account) external sphereXGuardExternal(0x0170875c) {
        AccessControl.revokeRole(OPERATOR, account);
    }

    function revokeSecurityAdmin(address account) external notSelf(account) sphereXGuardExternal(0x5c089013) {
        AccessControl.revokeRole(SECURITY_ADMIN, account);
    }

    function revokeSecurityAgent(address account) external sphereXGuardExternal(0x19946487) {
        AccessControl.revokeRole(SECURITY_AGENT, account);
    }

    function revokeTokenAdmin(address account) external sphereXGuardExternal(0xb014ca83) {
        AccessControl.revokeRole(TOKEN_ADMIN, account);
    }

    function revokeUpgradeGovernor(address account) external sphereXGuardExternal(0x0ca3f292) {
        AccessControl.revokeRole(UPGRADE_GOVERNOR, account);
    }

    // Renounce Role.
    function renounceRole(bytes32 role, address account) external sphereXGuardExternal(0xfc2a73c0) {
        if (role == GOVERNANCE_ADMIN && !fullyRenouncable) {
            revert("CANNOT_RENOUNCE_GOVERNANCE_ADMIN");
        }
        AccessControl.renounceRole(role, account);
    }
}
