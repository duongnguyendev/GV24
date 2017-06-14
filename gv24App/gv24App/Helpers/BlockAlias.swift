//
//  BlockAlias.swift
//  gv24App
//
//  Created by Macbook Solution on 5/29/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
typealias TaskNewCompletion = (_ tasks: [Task]?) -> ()
typealias ApplicantCompletion = (_ applicant: [Applicant]?,_ error: String?) -> ()
typealias TaskHistoryCompletion = (_ task: TaskHistory?) -> ()
typealias UnpaidWorkCompletion = (_ workUnpaids: [WorkUnpaid]?) -> ()
typealias MaidHistoryCompletion = (_ maids: [MaidHistory]?) -> ()
typealias MaidTaskCompletion = (_ maidTask: MaidTask?) -> ()
typealias TaskAssignedCompletion = (_ taskAssigned: [TaskAssigned]?) -> ()
