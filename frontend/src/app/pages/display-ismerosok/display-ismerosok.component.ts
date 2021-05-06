import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-display-ismerosok',
  templateUrl: './display-ismerosok.component.html',
  styleUrls: ['./display-ismerosok.component.scss']
})
export class DisplayIsmerosokComponent implements OnInit {

  users?: User[];

  queryUserId = 1;

  constructor(private userService: UserService, private router: Router) { }

  ngOnInit(): void {
    this.getUsers();
  }

  getUsers(): void {
    this.userService.getIsmeroses(this.queryUserId).subscribe(users => {
      this.users = users;
      console.log(this.users);
    });
  }

  getDate(): number {
    if (!this.users) return 0;
    return this.users[0].csatl.getTime();
  }
}
