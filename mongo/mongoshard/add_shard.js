printjson(db.runCommand( { addShard : "firstset/localhost:10001,localhost:10002,localhost:10003" }));
printjson(db.runCommand( { addShard : "secondset/localhost:10004,localhost:10005,localhost:10006" } ));


