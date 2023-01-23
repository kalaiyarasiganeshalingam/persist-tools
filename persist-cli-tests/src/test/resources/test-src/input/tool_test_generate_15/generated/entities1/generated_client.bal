// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for entities1.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;
import ballerina/time;

public client class Entities1Client {

    private final mysql:Client dbClient;

    private final map<persist:SQLClient> persistClients;

    private final map<persist:Metadata> metadata = {"multipleassociations": {entityName: "MultipleAssociations", tableName: "MultipleAssociations", id: {columnName: "id", 'type: int}, name: {columnName: "name", 'type: string}, profileId: {columnName: "profileId", 'type: int} keyFields: ["id"]}, "profile": {entityName: "Profile", tableName: "Profile", id: {columnName: "id", 'type: int}, name: {columnName: "name", 'type: string}, keyFields: ["id"]}};

    public function init() returns persist:Error? {
        self.dbClient = check new (host = host, user = user, password = password, database = database, port = port);
        self.persistClients = {"multipleassociations": check new (self.dbClient, self.metadata.get("multipleassociations").entityName, self.metadata.get("multipleassociations").tableName, self.metadata.get("multipleassociations").keyFields, self.metadata.get("multipleassociations").fieldMetadata), "profile": check new (self.dbClient, self.metadata.get("profile").entityName, self.metadata.get("profile").tableName, self.metadata.get("profile").keyFields, self.metadata.get("profile").fieldMetadata)};
    }

    public function close() returns persist:Error? {
        sql:Error? e = self.dbClient.close();
        if e is sql:Error {
            return <persist:Error>error(e.message());
        }
    }

    isolated resource function get multipleassociations() returns stream<MultipleAssociations, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClients.get("multipleassociations").runReadQuery(MultipleAssociations);
        if result is persist:Error {
            return new stream<MultipleAssociations, persist:Error?>(new MultipleAssociationsStream((), result));
        } else {
            return new stream<MultipleAssociations, persist:Error?>(new MultipleAssociationsStream(result));
        }
    }
    isolated resource function get multipleassociations/[int id]() returns MultipleAssociations|persist:Error {
        return (check self.persistClients.get("multipleassociations").runReadByKeyQuery(MultipleAssociations, id)).cloneWithType(MultipleAssociations);
    }
    isolated resource function post multipleassociations(MultipleAssociationsInsert[] data) returns [int][]|persist:Error {
        _ = check self.persistClients.get("multipleassociations").runBatchInsertQuery(data);
        return from MultipleAssociationsInsert inserted in data
            select [inserted.id];
    }
    isolated resource function put multipleassociations/[int id](MultipleAssociationsUpdate value) returns MultipleAssociations|persist:Error {
        _ = check self.persistClients.get("multipleassociations").runUpdateQuery({"id": id, }, data);
        return self->/multipleassociations/[id].get();
    }
    isolated resource function delete multipleassociations/[int id]() returns MultipleAssociations|persist:Error {
        MultipleAssociations 'object = check self->/multipleassociations/[id].get();
        _ = check self.persistClients.get("multipleassociations").runDeleteQuery({"id": id, });
        return 'object;
    }

    isolated resource function get profile() returns stream<Profile, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClients.get("profile").runReadQuery(Profile);
        if result is persist:Error {
            return new stream<Profile, persist:Error?>(new ProfileStream((), result));
        } else {
            return new stream<Profile, persist:Error?>(new ProfileStream(result));
        }
    }
    isolated resource function get profile/[int id]() returns Profile|persist:Error {
        return (check self.persistClients.get("profile").runReadByKeyQuery(Profile, id)).cloneWithType(Profile);
    }
    isolated resource function post profile(ProfileInsert[] data) returns [int][]|persist:Error {
        _ = check self.persistClients.get("profile").runBatchInsertQuery(data);
        return from ProfileInsert inserted in data
            select [inserted.id];
    }
    isolated resource function put profile/[int id](ProfileUpdate value) returns Profile|persist:Error {
        _ = check self.persistClients.get("profile").runUpdateQuery({"id": id, }, data);
        return self->/profile/[id].get();
    }
    isolated resource function delete profile/[int id]() returns Profile|persist:Error {
        Profile 'object = check self->/profile/[id].get();
        _ = check self.persistClients.get("profile").runDeleteQuery({"id": id, });
        return 'object;
    }
}

