// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for Dept.
// It should not be modified by hand.

import ballerina/constraint;
import ballerinax/mysql;
import ballerina/persist;
import ballerina/sql;

public client class DeptClient {
    *persist:AbstractPersistClient;

    private final string entityName = "Dept";
    private final sql:ParameterizedQuery tableName = `Dept`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        id: {columnName: "id", 'type: int},
        name: {columnName: "name", 'type: string},
        "multipleAssociations.id": {'type: int, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "id"}},
        "multipleAssociations.name": {'type: string, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "name"}}
    };
    private string[] keyFields = ["id"];

    private final map<persist:JoinMetadata> joinMetadata = {multipleAssociations: {entity: MultipleAssociations, fieldName: "multipleAssociations", refTable: "MultipleAssociations", refFields: ["deptId"], joinColumns: ["id"]}};

    private persist:SQLClient persistClient;

    public function init() returns persist:Error? {
        mysql:Client|sql:Error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is sql:Error {
            return <persist:Error>error(dbClient.message());
        }
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata, self.joinMetadata);
    }

    remote function create(Dept value) returns Dept|persist:Error {
        Dept|error validationResult = constraint:validate(value, Dept);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runInsertQuery(value);
        return value;
    }

    remote function readByKey(int key, DeptRelations[] include = []) returns Dept|persist:Error {
        return <Dept>check self.persistClient.runReadByKeyQuery(Dept, key, include);
    }

    remote function read(DeptRelations[] include = []) returns stream<Dept, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClient.runReadQuery(Dept, include);
        if result is persist:Error {
            return new stream<Dept, persist:Error?>(new DeptStream((), result));
        } else {
            return new stream<Dept, persist:Error?>(new DeptStream(result));
        }
    }

    remote function update(Dept value) returns persist:Error? {
        Dept|error validationResult = constraint:validate(value, Dept);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runUpdateQuery(value);
    }

    remote function delete(Dept value) returns persist:Error? {
        Dept|error validationResult = constraint:validate(value, Dept);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runDeleteQuery(value);
    }

    remote function exists(Dept dept) returns boolean|persist:Error {
        Dept|error validationResult = constraint:validate(dept, Dept);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        Dept|persist:Error result = self->readByKey(dept.id);
        if result is Dept {
            return true;
        } else if result is persist:InvalidKeyError {
            return false;
        } else {
            return result;
        }
    }

    public function close() returns persist:Error? {
        return self.persistClient.close();
    }
}

public enum DeptRelations {
    multipleAssociations
}

public class DeptStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|Dept value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                record {|Dept value;|} nextRecord = {value: <Dept>streamValue.value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            sql:Error? e = anydataStream.close();
            if e is sql:Error {
                return <persist:Error>error(e.message());
            }
        }
    }
}

