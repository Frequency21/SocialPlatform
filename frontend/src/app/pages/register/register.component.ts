import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  form: FormGroup = new FormGroup({
    username: new FormControl(),
    email: new FormControl(),
    password1: new FormControl(),
    password2: new FormControl()
  });

  constructor() { }

  ngOnInit(): void { }

  registration(): void {

  }

}
