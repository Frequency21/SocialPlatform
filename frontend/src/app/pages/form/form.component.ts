import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Subscription } from 'rxjs/internal/Subscription';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-form',
  templateUrl: './form.component.html',
  styleUrls: ['./form.component.scss']
})
export class FormComponent implements OnInit, OnDestroy {

  public readonly myFormGroup: FormGroup;
  subscription: Subscription;
  user?: User;
  public selectedFile?: File;

  ngOnInit(): void { }

  constructor(
    private readonly formBuilder: FormBuilder,
    private userService: UserService
  ) {

    this.subscription = this.userService.userSource.subscribe(user => this.user = user)
    
    this.myFormGroup = this.formBuilder.group({
      email: [],
      vnev: [],
      knev: [],
      szul_dat: [],
      munka_iskola: [],
      password1: [],
      password2: []
    });
    this.retrieveData();
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }


  private retrieveData(): void {
    this.myFormGroup.patchValue(this.user as Object);


    this.myFormGroup.patchValue({
      szul_dat: Date.now()
    })

  }



  onSelectFile(event: any) {
    this.selectedFile = event.target.files[event.target.files.length - 1] as File;
  }


}
