API
===

### Find service

```http
POST /find?class=<class> HTTP/1.1
Content-Type: image/jpeg


...JPEG...
```


Parameter | Required? | Value | Description
:-------- | :-------- | :---- | :----------
class     | yes       | keys  | The thing to look for



```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "class": "keys",
  "score": 0.8
}
```

Field     | Value | Description
:-------- | :---- | :----------
class     | keys  | The class being searched for
score     | 0.8   | Confidence item of that class is present (0.0 - 1.0)
