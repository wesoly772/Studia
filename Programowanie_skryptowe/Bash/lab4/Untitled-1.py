import shodan

api_key = "j52HUpxGYo5mWynjNfi5Z6cfCAlSmXCw"
request=shodan.Shodan(api_key)

results = request.host("121.229.0.135")
