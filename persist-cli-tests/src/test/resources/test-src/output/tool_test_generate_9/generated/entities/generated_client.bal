// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for entities.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;

public client class EntitiesClient {

    private final mysql:Client dbClient;

    private final map<persist:SQLClient> persistClients;

    private final map<persist:Metadata> metadata = {"medicalneed": {entityName: "MedicalNeed", tableName: "MedicalNeed", needId: {columnName: "needId", 'type: int}, itemId: {columnName: "itemId", 'type: int}, beneficiaryId: {columnName: "beneficiaryId", 'type: int}, period: {columnName: "period", 'type: time:Civil}, urgency: {columnName: "urgency", 'type: string}, quantity: {columnName: "quantity", 'type: int} keyFields: ["needId", "itemId"]}};

    public function init() returns persist:Error? {
        self.dbClient = check new (host = host, user = user, password = password, database = database, port = port);
        self.persistClients = {"medicalneed": check new (self.dbClient, self.metadata.get("medicalneed").entityName, self.metadata.get("medicalneed").tableName, self.metadata.get("medicalneed").keyFields, self.metadata.get("medicalneed").fieldMetadata)};
    }

    public function close() returns persist:Error? {
        sql:Error? e = self.dbClient.close();
        if e is sql:Error {
            return <persist:Error>error(e.message());
        }
    }

    isolated resource function get medicalneed() returns stream<MedicalNeed, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClients.get("medicalneed").runReadQuery(MedicalNeed);
        if result is persist:Error {
            return new stream<MedicalNeed, persist:Error?>(new MedicalNeedStream((), result));
        } else {
            return new stream<MedicalNeed, persist:Error?>(new MedicalNeedStream(result));
        }
    }
    isolated resource function get medicalneed/[int itemId]/[int needId]() returns MedicalNeed|persist:Error {
        record {| %s |} = {}        return (check self.persistClients.get("medicalneed").runReadByKeyQuery(MedicalNeed, record {|int itemId; int needId|})).cloneWithType(MedicalNeed);
    }
    isolated resource function post medicalneed(MedicalNeedInsert[] data) returns [int, int][]|persist:Error {
        _ = check self.persistClients.get("medicalneed").runBatchInsertQuery(data);
        return from MedicalNeedInsert inserted in data
            select [inserted.needId, inserted.itemId];
    }
    isolated resource function put medicalneed/[int itemId]/[int needId](MedicalNeedUpdate value) returns MedicalNeed|persist:Error {
        _ = check self.persistClients.get("medicalneed").runUpdateQuery({"itemId": itemId, "needId": needId, }, data);
        return self->/medicalneed/[itemId]/[needId].get();
    }
    isolated resource function delete medicalneed/[int itemId]/[int needId]() returns MedicalNeed|persist:Error {
        MedicalNeed 'object = check self->/medicalneed/[itemId]/[needId].get();
        _ = check self.persistClients.get("medicalneed").runDeleteQuery({"itemId": itemId, "needId": needId, });
        return 'object;
    }
}

