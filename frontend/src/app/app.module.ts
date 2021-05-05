import { ModalKommentModule } from './pages/modal-komment/modal-komment.module';
import { ModalPosztModule } from './pages/modal-poszt/modal-poszt.module';
import { MatDialogModule } from '@angular/material/dialog';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatCardModule } from '@angular/material/card';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
// TODO: moduleba szervezni majd
import { DisplayUsersComponent } from './pages/display-users/display-users.component';

// setup server communication
import { HttpClientModule } from "@angular/common/http";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

// desperate try, registerModulehoz kellett, de nem működött ezért itt is behúztam
import { RegisterModule } from './pages/register/register.module';
import { NavigationModule } from './pages/navigation/navigation.module';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { DisplayUserModule } from './pages/display-user/display-user.module';
import { DisplayUsersModule } from './pages/display-users/display-users.module';
import { DisplayPostsModule } from './pages/display-posts/display-posts.module';
import { DisplayGroupModule } from './pages/display-group/display-group.module';
import { DisplayGroupsModule } from './pages/display-groups/display-groups.module';
import { DisplayIsmerosokModule } from './pages/display-ismerosok/display-ismerosok.module';
import { ModalPosztComponent } from './pages/modal-poszt/modal-poszt.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,

    FormsModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatCardModule,
    MatToolbarModule,
    MatDialogModule,

    RegisterModule,
    NavigationModule,
    DisplayUserModule,
    DisplayUsersModule,
    DisplayPostsModule,
    DisplayGroupModule,
    DisplayGroupsModule,
    DisplayIsmerosokModule,
    ModalPosztModule,
    ModalKommentModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
