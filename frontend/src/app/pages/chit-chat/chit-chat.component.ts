import { Subscription } from 'rxjs';
import { UzenetService } from './../../services/uzenet.service';
import { UserService } from 'src/app/services/user.service';
import { Uzenet } from './../../shared/models/uzenet.model';
import { FormGroup, FormControl } from '@angular/forms';
import { Component, OnInit, Inject } from '@angular/core';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-chit-chat',
  templateUrl: './chit-chat.component.html',
  styleUrls: ['./chit-chat.component.scss']
})
export class ChitChatComponent implements OnInit {
  form: FormGroup = new FormGroup({
    szoveg: new FormControl()
  })
  sender?: User;
  friends?: User[];
  messages?: Uzenet[];
  chatId?: number;
  subscription: Subscription;

  constructor(
    private userService: UserService,
    private uzenetService: UzenetService
  ) {
    this.subscription = this.userService.userSource.subscribe(user => this.sender = user);
  }

  ngOnInit(): void {
    this.getFriends();
  }

  loadMessages(id: number): void {
    this.uzenetService.getUzenetForChat(Number(this.sender?.id), id).subscribe(msgs => {
      this.messages = msgs;
      console.log(this.messages);
    });
  }

  sendMessage(): void {
    let newUzenet: Uzenet = {
      id: undefined,
      idopont: "",
      kuldo_id: Number(this.sender?.id),
      cimzett_id: Number(this.chatId),
      szoveg: this.form.value.szoveg,
      fenykep: this.sender?.picture
    };
    this.uzenetService.sendMessage(newUzenet).subscribe(ret => {
      console.log(ret);
    });
    console.log(newUzenet);
  }

  getFriends(): void {
    this.userService.getFriendsById(Number(this.sender?.id)).subscribe(friends => {
      this.friends = friends;
    });
  }

  openChat(id: number): void {
    this.chatId = id;
    this.loadMessages(id);
  }

}
