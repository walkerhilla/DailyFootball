//
//  LeagueDetailStandingsViewModel.swift
//  DailyFootball
//
//  Created by walkerhilla on 2023/10/24.
//

import Foundation

final class LeagueDetailStandingsViewModel {
  
  private let fetchLeagueStandingsUseCase = FetchLeagueStandingsUseCase()
  
  var state: Observable<State> = Observable(.idle)
  
  func handle(action: Action) {
    switch action {
    case .fetchStandings(let season, let id):
      fetchStandings(season: season, id: id)
    }
  }
  
  private func fetchStandings(season: Int, id: Int) {
    fetchLeagueStandingsUseCase.execute(season: season, id: id) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let response):
        self.state.value = .standingsLoaded(response)
      case .failure(let error):
        self.state.value = .error(error)
      }
    }
  }
}

extension LeagueDetailStandingsViewModel {
  enum Action {
    case fetchStandings(season: Int, id: Int)
  }
  
  enum State {
    case idle
    case standingsLoaded([Standing])
    case error(Error)
  }
}