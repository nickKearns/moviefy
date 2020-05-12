//
//  ViewController.swift
//  Moviefy
//
//  Created by Adriana González Martínez on 3/12/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var popularMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    var collectionView: UICollectionView!
    var sections: [Section] = []
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        fetchPopular()
        fetchUpcoming()
    }
    
    func setupCollectionView() {
        let sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: .main), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(UINib(nibName: TitleCell.identifier, bundle: .main), forCellWithReuseIdentifier: TitleCell.identifier)
        self.view.addSubview(collectionView)
    }
    
    func fetchPopular(){
        let api = MovieDB.api
        api.send(request: .popularMovies(completion: { result in
            switch result {
            case .success(let page):
              print(page.results)
              self.popularMovies = page.results
              var basicSection = MovieSection()
              basicSection.numberOfItems = page.results.count
              basicSection.items = page.results
              self.sections.append(TitleSection(title: "Popular Movies"))
              self.sections.append(basicSection)
              self.setupCollectionView()
            case .failure(let error):  print(error)
            }
        }))
        
    
    }
    
    
    func fetchUpcoming() {
        let api = MovieDB.api
        api.send(request: .upcomingMovies(completion: { result in
            switch result {
            case .success(let page):
                self.upcomingMovies = page.results
                var basicSection = MovieSection()
                basicSection.numberOfItems = page.results.count
                basicSection.items = page.results
                self.sections.append(TitleSection(title: "Upcoming Movies"))
                self.sections.append(basicSection)
                self.setupCollectionView()
            case .failure(let error):
                print(error)
            }
            
            
            
        }))
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case is MovieSection:
            let section = sections[indexPath.section] as! MovieSection
            return section.configureCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
        }
        
    }
}

extension ViewController: UICollectionViewDelegate {}
