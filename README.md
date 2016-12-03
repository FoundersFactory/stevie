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
  "message": "<warmer|colder|you've found your CLASS>",
  "classifier_data":
	{
	  "images": [
	    {
	      "source_url": "string",
	      "resolved_url": "string",
	      "image": "string",
	      "error": {
		"error_id": "string",
		"description": "string"
	      },
	      "classifiers": [
		{
		  "name": "string",
		  "classifier_id": "string",
		  "classes": [
		    {
		      "class": "string",
		      "score": 0,
		      "type_hierarchy": "string"
		    }
		  ]
		}
	      ]
	    }
	  ],
	  "warnings": [
	    {
	      "warning_id": "string",
	      "description": "string"
	    }
	  ]
	}
}
```
