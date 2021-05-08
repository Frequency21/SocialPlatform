import { Router } from '@angular/router';
import { GroupService } from './../../services/group.service';
import { Component, OnInit } from '@angular/core';
import { Group } from 'src/app/shared/models/group.model';

@Component({
  selector: 'app-display-groups',
  templateUrl: './display-groups.component.html',
  styleUrls: ['./display-groups.component.scss']
})
export class DisplayGroupsComponent implements OnInit {

  groups?: Group[];

  constructor(private groupService: GroupService, private router: Router) { }

  ngOnInit(): void {
    this.getGroups();
  }

  getGroups(): void {
    this.groupService.getGroups().subscribe(groups => {
      this.groups = groups;
      console.log(this.groups)
    })
  }

}
