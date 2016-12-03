API
===

### Class list service

Get a list of supported object classes

Example request:

```http
GET /class_list HTTP/1.1
```

Example response:

```http
{
  "class_list": [
    "keys",
    "oreo",
    "card"
  ]
}
```

### Find service

Find an object class in a given image.  Given a specific object class, this endpoint returns a score
which represents the likelihood of the image containing that object.

Example request:

```http
POST /find?class=<class> HTTP/1.1
Content-Type: image/jpeg


...JPEG...
```

Parameter | Required? | Value | Description
:-------- | :-------- | :---- | :----------
class     | yes       | keys  | The thing to look for


Example response:


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
