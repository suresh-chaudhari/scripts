config={ _id: "thirdset", members:[
          { _id : 0, host : "localhost:10007"},
          { _id : 1, host : "localhost:10008"},
          { _id : 2, host : "localhost:10009"} ]
};
printjson(rs.initiate(config))
rs.status()



