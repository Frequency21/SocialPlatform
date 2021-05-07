import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  email = '';
  password = '';

  users: User[] = [];

  constructor(
    private router: Router,
    private userService: UserService,
    ) { }

  ngOnInit() {
  }

  handleSuccessfulResponse(response: any[])
  {
      this.users=response;
  }

  checkLogin() {
    try{
    this.userService.login(this.email, this.password)
      .subscribe((user => {
        if(user.id != null) {
          localStorage.setItem("id", String(user.id))
          this.router.navigate(['/']);
        } else {
          alert("Rossz felhasználónév, vagy jelszó");
        }
     }));
    }
    catch(error) {
      alert("Invalid login");
    }

  }


}
