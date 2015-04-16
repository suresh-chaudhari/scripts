config={ _id: "firstset", members:[
          { _id : 0, host : "localhost:10001"},
          { _id : 1, host : "localhost:10002"},
          { _id : 2, host : "localhost:10003"} ]
};
rs.initiate(config)
rs.status()



