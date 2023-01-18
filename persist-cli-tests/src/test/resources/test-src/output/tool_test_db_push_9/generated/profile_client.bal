// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for Profile.
// It should not be modified by hand.

import ballerina/constraint;
import ballerinax/mysql;
import ballerina/persist;
import ballerina/sql;

public client class ProfileClient {
    *persist:AbstractPersistClient;

    private final string entityName = "Profile";
    private final sql:ParameterizedQuery tableName = `Profile`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        id: {columnName: "id", 'type: int},
        name: {columnName: "name", 'type: string},
        "owner.id": {columnName: "userId", 'type: int, relation: {entityName: "owner", refTable: "User", refField: "id"}},
        "owner.name": {'type: string, relation: {entityName: "owner", refTable: "User", refField: "name"}},
        "multipleAssociations.id": {'type: int, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "id"}},
        "multipleAssociations.name": {'type: string, relation: {entityName: "multipleAssociations", refTable: "MultipleAssociations", refField: "name"}}
    };
    private string[] keyFields = ["id"];

    private final map<persist:JoinMetadata> joinMetadata = {
        owner: {entity: User, fieldName: "user", refTable: "User", refFields: ["id"], joinColumns: ["userId"]},
        multipleAssociations: {entity: MultipleAssociations, fieldName: "multipleAssociations", refTable: "MultipleAssociations", refFields: ["profileId"], joinColumns: ["id"]}
    };

    private persist:SQLClient persistClient;

    public function init() returns persist:Error? {
        mysql:Client|sql:Error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is sql:Error {
            return <persist:Error>error(dbClient.message());
        }
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata, self.joinMetadata);
    }

    remote function create(Profile value) returns Profile|persist:Error {
        Profile|error validationResult = constraint:validate(value, Profile);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        if value.owner is User {
            UserClient userClient = check new UserClient();
            boolean exists = check userClient->exists(<User>value.owner);
            if !exists {
                value.owner = check userClient->create(<User>value.owner);
            }
        }
        _ = check self.persistClient.runInsertQuery(value);
        return value;
    }

    remote function readByKey(int key, ProfileRelations[] include = []) returns Profile|persist:Error {
        return <Profile>check self.persistClient.runReadByKeyQuery(Profile, key, include);
    }

    remote function read(ProfileRelations[] include = []) returns stream<Profile, persist:Error?> {
        stream<anydata, sql:Error?>|persist:Error result = self.persistClient.runReadQuery(Profile, include);
        if result is persist:Error {
            return new stream<Profile, persist:Error?>(new ProfileStream((), result));
        } else {
            return new stream<Profile, persist:Error?>(new ProfileStream(result));
        }
    }

    remote function update(Profile value) returns persist:Error? {
        Profile|error validationResult = constraint:validate(value, Profile);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runUpdateQuery(value);
        if value.owner is record {} {
            User userEntity = <User>value.owner;
            UserClient userClient = check new UserClient();
            check userClient->update(userEntity);
        }
    }

    remote function delete(Profile value) returns persist:Error? {
        Profile|error validationResult = constraint:validate(value, Profile);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        _ = check self.persistClient.runDeleteQuery(value);
    }

    remote function exists(Profile profile) returns boolean|persist:Error {
        Profile|error validationResult = constraint:validate(profile, Profile);
        if validationResult is error {
            return <persist:Error>error(validationResult.message());
        }
        Profile|persist:Error result = self->readByKey(profile.id);
        if result is Profile {
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

public enum ProfileRelations {
    owner, multipleAssociations
}

public class ProfileStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|Profile value;|}|persist:Error? {
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
                record {|Profile value;|} nextRecord = {value: <Profile>streamValue.value};
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

