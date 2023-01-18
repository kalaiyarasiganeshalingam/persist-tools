// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for entities.
// It should not be modified by hand.

import ballerina/persist;

public client class EntitiesClient {
    *persist:AbstractPersistClient;

    isolated resource function get medicalneed() returns stream<MedicalNeed, persist:Error?> {
        return new ();
    }
    isolated resource function get medicalneed/[int needId]() returns MedicalNeed|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function post medicalneed(MedicalNeedInsert[] data) returns int[]|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function put medicalneed/[int needId](MedicalNeedUpdate value) returns MedicalNeed|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function delete medicalneed/[int needId]() returns MedicalNeed|persist:Error {
        return error persist:Error("unsupported operation");
    }

    isolated resource function get aidpackageorderitem() returns stream<AidPackageOrderItem, persist:Error?> {
        return new ();
    }
    isolated resource function get aidpackageorderitem/[int id]() returns AidPackageOrderItem|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function post aidpackageorderitem(AidPackageOrderItemInsert[] data) returns int[]|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function put aidpackageorderitem/[int id](AidPackageOrderItemUpdate value) returns AidPackageOrderItem|persist:Error {
        return error persist:Error("unsupported operation");
    }
    isolated resource function delete aidpackageorderitem/[int id]() returns AidPackageOrderItem|persist:Error {
        return error persist:Error("unsupported operation");
    }
}

