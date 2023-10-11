<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Buat Jadwal Rapat Disini</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <form method="post" action="<?php echo base_url() ?>jadwal/put/<?php echo $id_komunitas ?>/<?= $jadwal->id ?>">
                            <div class=" p-lg-3">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label">Judul Rapat</label>
                                            <input type="text" name="judul_rapat" class="form-control" value="<?= $jadwal->judul_rapat ?>" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label">Detail Rapat</label>
                                            <textarea rows="4" name="detail" class="form-control" required><?= $jadwal->isi ?></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Date</label>
                                            <input type="date" name="tanggal" data-date-format="yyyy-mm-dd" class="form-control datepicker" placeholder="YYYY/MM/DD" value="<?= $jadwal->tanggal ?>" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Time</label>
                                            <input type="time" name="waktu" class="form-control" placeholder="hh:mm" value="<?= $jadwal->waktu ?>" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mt-3">
                                        <input type="submit" name="submit" value="Update Jadwal" class="btn btn-danger">
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