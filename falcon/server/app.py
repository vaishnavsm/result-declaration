import falcon

class HelloWorld:
    def on_get(self, req, resp):
        """Handles GET requests"""

        resp.media = {"Message":"Hello World!"}

api = falcon.API()
api.add_route('/', HelloWorld())