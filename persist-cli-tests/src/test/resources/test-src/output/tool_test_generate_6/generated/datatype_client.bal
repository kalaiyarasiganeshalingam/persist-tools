// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for DataType.
// It should not be modified by hand.

import ballerina/constraint;
import ballerinax/mysql;
import ballerina/persist;
import ballerina/sql;
import ballerina/time;

public client class DataTypeClient {
    *persist:AbstractPersistClient;

    private final string entityName = "DataType";
    private final sql:ParameterizedQuery tableName = `DataType`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        a: {columnName: "a", 'type: int, autoGenerated: true},
        b1: {columnName: "b1", 'type: string},
        c1: {columnName: "c1", 'type: int},
        d1: {columnName: "d1", 'type: boolean},
        e1: {columnName: "e1", 'type: float},
        f1: {columnName: "f1", 'type: decimal},
        j1: {columnName: "j1", 'type: time:Utc},
        k1: {columnName: "k1", 'type: time:Civil},
        l1: {columnName: "l1", 'type: time:Date},
        m1: {columnName: "m1", 'type: time:TimeOfDay}
    };
    private string[] keyFields = ["a"];

    private persist:SQLClient persistClient;

    public function init() returns persist:Error? {
        mysql:Client|sql:Error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is sql:Error {
            return <persist:Error>error(dbClient.message());
        }
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata);
    }

    remote function create(DataType value) returns DataType|persist:Error {
        DataType|error validationResult = constraint:validate(value, DataType);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        sql:ExecutionResult result = check self.persistClient.runInsertQuery(value);
        return {a: <int>result.lastInsertId, b1: value.b1, c1: value.c1, d1: value.d1, e1: value.e1, f1: value.f1, j1: value.j1, k1: value.k1, l1: value.l1, m1: value.m1};
    }

    remote function readByKey(int key) returns DataType|persist:Error {
        return <DataType>check self.persistClient.runReadByKeyQuery(DataType, key);
    }

    remote function read() returns stream<DataType, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClient.runReadQuery(DataType);
        if result is persist:Error {
            return new stream<DataType, persist:Error?>(new DataTypeStream((), result));
        } else {
            return new stream<DataType, persist:Error?>(new DataTypeStream(result));
        }
    }

    remote function update(DataType value) returns persist:Error? {
        DataType|error validationResult = constraint:validate(value, DataType);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runUpdateQuery(value);
    }

    remote function delete(DataType value) returns persist:Error? {
        DataType|error validationResult = constraint:validate(value, DataType);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runDeleteQuery(value);
    }

    remote function exists(DataType dataType) returns boolean|persist:Error {
        DataType|error validationResult = constraint:validate(dataType, DataType);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        DataType|persist:Error result = self->readByKey(dataType.a);
        if result is DataType {
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

public class DataTypeStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|DataType value;|}|persist:Error? {
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
                record {|DataType value;|} nextRecord = {value: <DataType>streamValue.value};
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

