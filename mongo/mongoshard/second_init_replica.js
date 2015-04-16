config={ _id: "secondset", members:[
          { _id : 0, host : "localhost:10004"},
          { _id : 1, host : "localhost:10005"},
          { _id : 2, host : "localhost:10006"} ]
};
printjson(rs.initiate(config))
printjson(rs.status())



