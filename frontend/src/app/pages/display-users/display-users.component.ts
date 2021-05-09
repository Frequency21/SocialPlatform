import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user.service';
import { User } from "../../shared/models/user.model";
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-display-users',
  templateUrl: './display-users.component.html',
  styleUrls: ['./display-users.component.scss']
})
export class DisplayUsersComponent implements OnInit {

  users?: User[];
  user?: User;

  constructor(
    private userService: UserService,
    private router: Router
    ) {

   }

  ngOnInit(): void {
    this.getUsers();
    this.userService.userSource.subscribe(user => {
      this.user = user;
      console.log(this.user?.id);
    });
  }

  getUsers(): void {
    this.userService.getUsers().subscribe(users => {
      this.users = users;
    });
  }

  getDate(): number {
    if (!this.users) return 0;
    return this.users[0].csatl.getTime();
  }

  isLoggedIn(): boolean {
    return (this.user == undefined);
  }

  flag(id: number): void {
    this.userService.flagIsmeros(Number(this.user?.id), id).subscribe(ret => {
      console.log(ret);
    })
  }

}
