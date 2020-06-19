# Utility
Convenient programs or knowledge that benefit my life.

## Elasticsearch
A useful database for storing and searching data. One could use this to achieve keyword searching.

Breif Manual:
1. Download Elasticsearch from https://www.elastic.co/downloads/elasticsearch.
 If you're using Windows, you may open elasticsearch database by execute "elasticsearch.bat". Then, you may enter 127.0.0.1:9200 to check whether the database has opened properly. Addionally, make sure you have the latest JDK and the right PATH (environment varible) is set.
2. pip install elasticsearch (different platform will have different install command)
3. (Optional) Download Kibana to visualize the data. https://www.elastic.co/downloads/kibana
4. Import data.
First of all, you will need to create a JSON file that contains the data you want to import. The format will look like this: 

{ "index" : { "_index" : "test", "_id" : "1" } }<br/>
{ "field1" : "value1" }<br/>
{ "index" : { "_index" : "test", "_id" : "2" } }<br/>
{ "field1" : "value2" }<br/>
...

In python code: <br/>
```
 
def read_data():  <br/>
    for data in data_set:  <br/>
        d=dict()  
        #transform your data into dictionary, which is "d"   
        d=json.dumps(d)  
        d=json.loads(d)  
        yield d   
    

with open("test_all_data.json",'w') as file_output:  
    for d in read_data():  
        api={ "index" : { "_index" : "recipes", "_id" : d['id'] } }  
        json.dump(api,file_output)  
        file_output.write("\n")  
        json.dump(d,file_output)  
        file_output.write("\n")  
        

```

The first line is request body, which tells Elasticsearch what to do with the following data. To be more specific, it may tell Elaticsearch where you want to put your data (the "_index" field) etc.
The second line is your data.

Then, you will use   
curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/_bulk?pretty" --data-binary "@fileName.json"; echo   
or  
curl -s -H "Content-Type: application/x-ndjson" -XPOST localhost:9200/_bulk --data-binary "@fileName.json"; echo   
idk their differences for now.   

***Detail: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html
***Data_format: https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html

5. Query data.  
If you have download Kibana, you can open the Dev Tool and enter command.  
If you didn't download it, you can use cURL in your CLI, or use some other programming language, like python3.  
In python3:  
```
from elasticsearch import Elasticsearch  
es=Elasticsearch()    
res=es.search(index="your_data_index",body={  
    "query": { "match": { "field1": "keyword_of_the_value" } }  
})  
```
There are more commands can be used and more matching method can be utilized.  
### Conclusion
**extra info
Chinese: https://soarlin.github.io/2016/11/13/elasticsearch-note-operation/
