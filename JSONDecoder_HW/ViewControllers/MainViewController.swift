import UIKit

private let link = "https://random.dog/woof.json"

class MainViewController: UIViewController {

    @IBAction func gedJsonButton() {
        fetchImage()
    }
}

extension MainViewController {
    private func fetchImage() {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            do {
                let info = try JSONDecoder().decode(DogImage.self, from: data)
                print(info)
                self?.successAlert()
            } catch let error {
                print(error.localizedDescription)
                self?.failedAlert()
            }
        }.resume()
    }
}

extension MainViewController {
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Успешно", message: "Результат отображен в консоле", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "Информация об ошибке отображена в консоле", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
