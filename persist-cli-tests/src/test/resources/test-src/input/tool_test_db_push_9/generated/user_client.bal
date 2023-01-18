// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for User.
// It should not be modified by hand.

import ballerina/constraint;
import ballerinax/mysql;
import ballerina/persist;
import ballerina/sql;

public client class UserClient {
    *persist:AbstractPersistClient;

    private final string entityName = "User";
    private final sql:ParameterizedQuery tableName = `User`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        id: {columnName: "id", 'type: int},
        name: {columnName: "name", 'type: string},
        "multipleAssociations.id": {'type: int, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "id"}},
        "multipleAssociations.name": {'type: string, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "name"}},
        "profile.id": {'type: int, relation: {entityName: "profile", refTable: "Profile", refField: "id"}},
        "profile.name": {'type: string, relation: {entityName: "profile", refTable: "Profile", refField: "name"}}
    };
    private string[] keyFields = ["id"];

    private final map<persist:JoinMetadata> joinMetadata = {
        multipleAssociations: {entity: MultipleAssociations, fieldName: "multipleAssociations", refTable: "MultipleAssociations", refFields: ["userId"], joinColumns: ["id"]},
        profile: {entity: Profile, fieldName: "profile", refTable: "Profile", refFields: ["userId"], joinColumns: ["id"]}
    };

    private persist:SQLClient persistClient;

    public function init() returns persist:Error? {
        mysql:Client|sql:Error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is sql:Error {
            return <persist:Error>error(dbClient.message());
        }
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata, self.joinMetadata);
    }

    remote function create(User value) returns User|persist:Error {
        User|error validationResult = constraint:validate(value, User);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runInsertQuery(value);
        return value;
    }

    remote function readByKey(int key, UserRelations[] include = []) returns User|persist:Error {
        return <User>check self.persistClient.runReadByKeyQuery(User, key, include);
    }

    remote function read(UserRelations[] include = []) returns stream<User, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClient.runReadQuery(User, include);
        if result is persist:Error {
            return new stream<User, persist:Error?>(new UserStream((), result));
        } else {
            return new stream<User, persist:Error?>(new UserStream(result));
        }
    }

    remote function update(User value) returns persist:Error? {
        User|error validationResult = constraint:validate(value, User);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runUpdateQuery(value);
    }

    remote function delete(User value) returns persist:Error? {
        User|error validationResult = constraint:validate(value, User);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runDeleteQuery(value);
    }

    remote function exists(User user) returns boolean|persist:Error {
        User|error validationResult = constraint:validate(user, User);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        User|persist:Error result = self->readByKey(user.id);
        if result is User {
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

public enum UserRelations {
    multipleAssociations, profile
}

public class UserStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|User value;|}|persist:Error? {
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
                record {|User value;|} nextRecord = {value: <User>streamValue.value};
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

