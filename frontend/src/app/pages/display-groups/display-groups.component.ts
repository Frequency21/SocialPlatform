import { UserService } from 'src/app/services/user.service';
import { Subscription } from 'rxjs';
import { ModalGroupComponent } from './../modal-group/modal-group.component';
import { Router } from '@angular/router';
import { GroupService } from './../../services/group.service';
import { Component, OnInit } from '@angular/core';
import { Group } from 'src/app/shared/models/group.model';
import { MatDialog } from '@angular/material/dialog';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-display-groups',
  templateUrl: './display-groups.component.html',
  styleUrls: ['./display-groups.component.scss']
})
export class DisplayGroupsComponent implements OnInit {

  groups?: Group[];
  currentUser?: User;
  subscription: Subscription;

  constructor(private groupService: GroupService, private router: Router, public dialog: MatDialog, private userService: UserService) {
    this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
  }


  ngOnInit(): void {
    this.getGroups();
  }

  loggedIn(): boolean {
    return this.currentUser == undefined;
  }

  getGroups(): void {
    this.groupService.getGroups().subscribe(groups => {
      this.groups = groups;
      console.log(this.groups)
    })
  }

  openDialog(){
    const dialogRef = this.dialog.open(ModalGroupComponent, {
      width: '40%',
      data: {tulaj_id : this.currentUser?.id}
    });

    dialogRef.afterClosed().subscribe(result => {
      // console.log('The dialog was closed');
    });
  }

}
