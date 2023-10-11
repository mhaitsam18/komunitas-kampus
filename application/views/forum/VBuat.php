<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Buat Komunitas</h2>
                        <p class="text-white mb-2">Buat komunitas kamu sendiri disini</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Buat thread kamu disini</h4>
                    </div>
                    <div class="card-body">
                        <form method="post" action="<?php echo base_url() ?>forum/store">
                            <div class="p-lg-3">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label" for="input-username">Judul Thread</label>
                                            <input type="text" name="judul" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Pilih Komunitas</label>
                                            <select name="komunitas" class="form-control" required>
                                                <?php foreach ($komunitas as $k) { ?>
                                                    <option value="<?php echo $k->token ?>"><?php echo $k->nama ?></option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label">Thread Kamu</label>
                                            <textarea rows="10" name="isi" class="form-control" required></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mt-3">
                                        <input type="submit" name="submit" value="Buat Thread" class="btn btn-danger">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>