import KituraNet
import Kitura

var usingLocal: Bool = false
var localUrl: String = ""
public var localerr: String = ""
func createServer(port: Int, res: String) {
    let router = Router()
    
    router.get("/") { request, response, next in
        response.send(res)
        next()
    }
    
    do {
        _ = try HTTPServer.listen(on: port, delegate: router)
        print("Server started on port \(port)")
        ListenerGroup.waitForListeners()
        usingLocal = true
        localUrl = "localhost:\(port)"
    } catch {
        print("Error starting server: \(error)")
        localerr = error.localizedDescription
    }
}

func checkLocalServer() -> Bool {
    if usingLocal {
        return true
    } else {
        return false
    }
}
