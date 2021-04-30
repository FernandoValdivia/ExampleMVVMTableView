import Foundation

class ViewModelPost{
    
    var refreshData = {
        () -> () in
    }
    
    var dataArrayPost: [Post] = [] {
        didSet{
            refreshData()
        }
    }
    
    func getDataPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else { return }
              
        URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let json = data else { return }
               
               do {
                    let decoder = JSONDecoder()
                    self.dataArrayPost = try decoder.decode([Post].self, from: json)
               } catch let error as NSError {
                   print(error.localizedDescription)
               }
           }.resume()
    }
}
