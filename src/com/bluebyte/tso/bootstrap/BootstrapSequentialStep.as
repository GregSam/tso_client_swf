package com.bluebyte.tso.bootstrap
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class BootstrapSequentialStep extends BootstrapStep implements IBootstrap 
    {

        protected var steps:Vector.<BootstrapStep>;
        private var numSteps:int = 0;
        private var activeStep:BootstrapStep;
        private var totalWeight:Number = 0;
        private var completedWeight:Number = 0;

        public function BootstrapSequentialStep():void
        {
            super();
            this.steps = new Vector.<BootstrapStep>();
        }

        override public function getProgress():Number
        {
            if (this.numSteps == 0)
            {
                return (1);
            };
            var _local_1:Number = this.completedWeight;
            if (this.activeStep != null)
            {
                _local_1 = (_local_1 + (this.activeStep.getProgress() * this.activeStep.getProgressWeight()));
            };
            return (Math.max(0, Math.min(1, (_local_1 / this.totalWeight))));
        }

        override public function next(_arg_1:BootstrapStep):void
        {
            if (this.steps.length > 0)
            {
                getBootstrap().dispatchEvent(new BootstrapEvent(BootstrapEvent.PROGRESS, _arg_1.getLoadingProgressStep()));
                this.completedWeight = (this.completedWeight + this.activeStep.getProgressWeight());
                this.activeStep = this.steps.shift();
                this.activeStep._execute();
            }
            else
            {
                getBootstrap().dispatchEvent(new BootstrapEvent(BootstrapEvent.PROGRESS, _arg_1.getLoadingProgressStep()));
                this.completedWeight = (this.completedWeight + this.activeStep.getProgressWeight());
                this.activeStep = null;
                super.next(this);
            };
        }

        public function add(_arg_1:BootstrapStep):IBootstrap
        {
            this.steps.push(_arg_1);
            _arg_1.setBootstrap(this);
            return (this);
        }

        public function start():void
        {
        }

        override protected function execute():void
        {
            var _local_1:BootstrapStep;
            this.numSteps = this.steps.length;
            this.totalWeight = 0;
            this.completedWeight = 0;
            for each (_local_1 in this.steps)
            {
                this.totalWeight = (this.totalWeight + _local_1.getProgressWeight());
            };
            this.activeStep = this.steps.shift();
            this.activeStep._execute();
        }

        public function getRemainingSteps(_arg_1:BootstrapStep):Vector.<BootstrapStep>
        {
            return (this.steps.concat());
        }


    }
}
