db = db.getSiblingDB("london");

agg_base = db.rides.aggregate([
    { '$addFields': { 'start_time': { '$toDate': "$start_time" }} },
    { '$addFields': { 'finish_time': { '$toDate': "$finish_time" }} },
    { '$addFields': { 'start_hour': { '$hour': "$start_time" }} },
    { '$addFields': { 'finish_hour': { '$hour': "$finish_time" }}},
    { "$group" : { _id : { "start_hour" : "$start_hour" , "finish_hour" : "$finish_hour" } ,'count' : { "$sum" : 1 }} },
    { "$sort": {"count" : -1}},
    { '$limit' : 1 }
]);

while (agg_base.hasNext()) {
    printjson(agg_base.next());
}

