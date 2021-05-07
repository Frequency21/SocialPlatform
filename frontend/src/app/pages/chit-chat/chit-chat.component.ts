import { UserService } from 'src/app/services/user.service';
import { Uzenet } from './../../shared/models/uzenet.model';
import { FormGroup, FormControl } from '@angular/forms';
import { Component, OnInit, Inject } from '@angular/core';

@Component({
  selector: 'app-chit-chat',
  templateUrl: './chit-chat.component.html',
  styleUrls: ['./chit-chat.component.scss']
})
export class ChitChatComponent implements OnInit {
  form: FormGroup = new FormGroup({
    szoveg: new FormControl()
  })
  senderID?: number;

  constructor(
    private userService: UserService
  ) { }

  ngOnInit(): void {
  }

  sendMessage(): void {
    this.getCurrentUser();
    let newUzenet: Uzenet = {
      id: undefined,
      idopont: "",
      kuldo_id: Number(this.senderID),
      cimzett_id: 0,
      szoveg: this.form.value.szoveg
    };
    console.log(newUzenet);
  }

  getCurrentUser(): void {
    this.userService.userSource.subscribe(user => {
      this.senderID = Number(user.id);
    })
  }

}
