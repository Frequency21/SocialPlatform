import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClientService } from 'src/app/services/httpclient.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  user!: User;

  form: FormGroup = new FormGroup({
    username: new FormControl(),
    email: new FormControl(),

    // email: new FormControl(),
    vnev: new FormControl(),
    knev: new FormControl(),
    //csatl: new FormControl(),
    szul_dat: new FormControl(),
    munka_iskola: new FormControl(),
    // picture?: new FormControl(),
    password1: new FormControl(),
    password2: new FormControl(),
  });

  constructor(
    private router: Router,
    private httpClientService: HttpClientService,
    ) { }

  ngOnInit(): void { }

  registration(): void {


    try {
      this.httpClientService.createAccount(this.user)
      .subscribe((data => {
        
        alert("Update succesful")
      }))
    }catch(error) {
      alert(error);
    }
  }

}
