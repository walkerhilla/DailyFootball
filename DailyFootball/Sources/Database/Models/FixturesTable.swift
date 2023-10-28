//
//  FixturesTable.swift
//  DailyFootball
//
//  Created by walkerhilla on 2023/10/27.
//

import Foundation
import RealmSwift

final class FixtureTable: Object {
  @Persisted(primaryKey: true) var competitionId: Int
  @Persisted var info: CompetitionInfoTable?
  @Persisted var date: Date
  @Persisted var update: Date
  @Persisted var country: CountryTable?
  @Persisted var season: String
  @Persisted var fixtureData: List<FixtureDataTable>
}

final class FixtureDataTable: Object {
  @Persisted(primaryKey: true) var fixtureId: Int
  @Persisted var round: String?
  @Persisted var referee: String?
  @Persisted var timezone: String?
  @Persisted var timestamp: Int?
  @Persisted var periods: PeriodsTable?
  @Persisted var venue: VenueTable?
  @Persisted var status: StatusTable?
  @Persisted var teams: TeamsTable?
  @Persisted var goals: homeAwayGoalsTable?
  @Persisted var score: ScoreTable?
}

final class PeriodsTable: EmbeddedObject {
  @Persisted var first: Int?
  @Persisted var second: Int?
}

final class StatusTable: EmbeddedObject {
  @Persisted var long: String
  @Persisted var short: String
  @Persisted var elapsed: Int?
}

final class TeamsTable: EmbeddedObject {
  @Persisted var home: TeamTable?
  @Persisted var away: TeamTable?
}

final class homeAwayGoalsTable: EmbeddedObject {
  @Persisted var home: Int?
  @Persisted var away: Int?
}

final class ScoreTable: EmbeddedObject {
  @Persisted var halftime: homeAwayGoalsTable?
  @Persisted var fulltime: homeAwayGoalsTable?
  @Persisted var extratime: homeAwayGoalsTable?
  @Persisted var penalty: homeAwayGoalsTable?
}
