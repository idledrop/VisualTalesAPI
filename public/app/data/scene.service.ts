import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService, IEvent} from './data';

@Injectable()
export class SceneService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<IScene>) {
    _visualTalesHttp.setUrl('poses');
  }
  
  updateScene(payload:any):Observable<IScene>{
    return this._visualTalesHttp.update(payload);
  }
  
  deleteScene(id:number):Observable<{}>{
    return this._visualTalesHttp.delete(id);
  }
  
  getEventsForScene(id:number):Observable<IEvent[]>{
    return this._visualTalesHttp.getChildren<IEvent>(id, 'events');
  }
  
  addEventToScene(id:number, payload:any):Observable<IEvent>{
    return this._visualTalesHttp.createChild<IEvent>(id, 'events', payload);
  }
}

export interface IScene{
  id?:number;
  name:string;
}