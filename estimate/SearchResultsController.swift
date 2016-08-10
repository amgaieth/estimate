import UIKit

protocol SelectedCellProtocol   {
    func didSelectedCell(text: String)
}

class SearchResultsController: UITableViewController {

    var address = String()
    var searchResults: [String]!
    
    var delegate:SelectedCellProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResults = Array()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.searchResults.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        // 1
        self.dismissViewControllerAnimated(true, completion: nil)
        
        address = searchResults[indexPath.row]
        delegate?.didSelectedCell(address)
    }
    
    func reloadDataWithArray(array:[String]){
        self.searchResults = array
        self.tableView.reloadData()
    }
    
    
}

