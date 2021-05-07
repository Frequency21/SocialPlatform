import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user.service';
import { User } from "../../shared/models/user.model";

@Component({
  selector: 'app-display-users',
  templateUrl: './display-users.component.html',
  styleUrls: ['./display-users.component.scss']
})
export class DisplayUsersComponent implements OnInit {

  users?: User[];

  constructor(private userService: UserService, private router: Router) { }

  ngOnInit(): void {
    this.getUsers();
  }

  getUsers(): void {
    this.userService.getUsers().subscribe(users => {
      this.users = users;
      // console.log(this.users);
    });
  }

  getDate(): number {
    if (!this.users) return 0;
    return this.users[0].csatl.getTime();
  }

}
